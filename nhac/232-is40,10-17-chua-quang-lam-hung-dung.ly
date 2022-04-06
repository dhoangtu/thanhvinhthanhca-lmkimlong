% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Quang Lâm Hùng Dũng" }
  composer = "Is. 40,10-17"
  tagline = ##f
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
     (set! all-grob-descriptions
           (cons ((@@ (lily) completize-grob-entry)
                  (cons grob-name grob-entry))
                 all-grob-descriptions)))

#(add-grob-definition
    'StanzaNumberSpanner
    `((direction . ,LEFT)
      (font-series . bold)
      (padding . 1.0)
      (side-axis . ,X)
      (stencil . ,ly:text-interface::print)
      (X-offset . ,ly:side-position-interface::x-aligned-side)
      (Y-extent . ,grob::always-Y-extent-from-stencil)
      (meta . ((class . Spanner)
               (interfaces . (font-interface
                              side-position-interface
                              stanza-number-interface
                              text-interface))))))

\layout {
    \context {
      \Global
      \grobdescriptions #all-grob-descriptions
    }
    \context {
      \Score
      \remove Stanza_number_align_engraver
      \consists
        #(lambda (context)
           (let ((texts '())
                 (syllables '()))
             (make-engraver
              (acknowledgers
               ((stanza-number-interface engraver grob source-engraver)
                  (set! texts (cons grob texts)))
               ((lyric-syllable-interface engraver grob source-engraver)
                  (set! syllables (cons grob syllables))))
              ((stop-translation-timestep engraver)
                 (for-each
                  (lambda (text)
                    (for-each
                     (lambda (syllable)
                       (ly:pointer-group-interface::add-grob
                        text
                        'side-support-elements
                        syllable))
                     syllables))
                  texts)
                 (set! syllables '())))))
    }
    \context {
      \Lyrics
      \remove Stanza_number_engraver
      \consists
        #(lambda (context)
           (let ((text #f)
                 (last-stanza #f))
             (make-engraver
              ((process-music engraver)
                 (let ((stanza (ly:context-property context 'stanza #f)))
                   (if (and stanza (not (equal? stanza last-stanza)))
                       (let ((column (ly:context-property context
'currentCommandColumn)))
                         (set! last-stanza stanza)
                         (if text
                             (ly:spanner-set-bound! text RIGHT column))
                         (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                         (ly:grob-set-property! text 'text stanza)
                         (ly:spanner-set-bound! text LEFT column)))))
              ((finalize engraver)
                 (if text
                     (let ((column (ly:context-property context
'currentCommandColumn)))
                       (ly:spanner-set-bound! text RIGHT column)))))))
      \override StanzaNumberSpanner.horizon-padding = 10000
    }
}

stanzaReminderOff =
  \temporary \override StanzaNumberSpanner.after-line-breaking =
     #(lambda (grob)
        ;; Can be replaced with (not (first-broken-spanner? grob)) in 2.23.
        (if (let ((siblings (ly:spanner-broken-into (ly:grob-original grob))))
              (and (pair? siblings)
                   (not (eq? grob (car siblings)))))
            (ly:grob-suicide! grob)))

stanzaReminderOn = \undo \stanzaReminderOff
% kết thúc mã nguồn

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 c8 f |
  f8. e16 e8 d |
  a'4 \tuplet 3/2 { a8 f e } |
  d4. g8 |
  g2 ~ |
  g4 r8 g16 e |
  e4 \tuplet 3/2 { c'8 c d } |
  a4 r8 b16 g |
  g4 \tuplet 3/2 { d'8 d b } |
  c2 ~ |
  c4 \bar "||" \break
  
  e,8 d16 c |
  \slashedGrace { \parenthesize c16 ( } d8) e f d |
  g4. g16 c |
  b8 d e c |
  a2 ~ |
  a4 r8 a16 g |
  g8 a f e |
  d4. d16 \slashedGrace { \parenthesize d16 ( } e) |
  c8 c e16 (f) a8 |
  g2 ~ |
  g4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  \partial 4 c8 f |
  f8. e16 e8 d |
  f4 \tuplet 3/2 { f8 d c } |
  c4. c8 |
  b2 ~ |
  b4 r8 b16 b |
  c4 \tuplet 3/2 { e8 e g } |
  f4 r8 d16 d |
  e4 \tuplet 3/2 { f8 f g } |
  e2 ~ |
  e4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Kìa Đức Chúa quang lâm hùng dũng,
  nắm trọn chủ quyền trong tay,
  Bên cạnh Ngài, uy công lẫm liệt,
  Trước mặt Ngài, chiến tích lừng vang.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Chúa như mục \markup { \italic \underline "tử" }
      chăn dắt đàn chiên,
      Tập trung lại dưới cánh tay Ngài.
      Lũ chiên con ấp ủ bên lòng,
      Bầy chiên mẹ tận tình đỡ nâng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Có ai lường \markup { \italic \underline "biển" }
	    trong vốc bàn tay,
	    Dùng gang mà đo chín cung trời,
	    Lấy thưng đong cát bụi trên đời,
	    Gom núi đồi đặt thử cán cân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Có ai cần \markup { \italic \underline "để" }
	    cho Chúa hỏi đâu,
	    Thần Khí Ngài ai biết đo lường,
	    Lấy ai tham vẫn để tinh tường,
	    Ai mách Ngài nẻo đường chính ngay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Kiếm ai dạy \markup { \italic \underline "để" }
	    tri thức mở mang,
	    Ngàn dân tựa như nước miệng thùng,
	    Giống trên cân chút bụi bám lại,
	    Muôn \markup { \italic \underline "đảo" }
	    nặng tựa hạt cát thôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Gỗ trên rừng Ly -- băng chẳng đủ thiêu,
	    Vật để làm hy lễ đâu vừa,
	    Trước Thiên Nhan hết mọi dân tộc,
	    Đâu đáng gì, huyền ảo, rỗng không.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = #1
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
