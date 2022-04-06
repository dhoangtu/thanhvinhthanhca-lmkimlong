% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Tuổi Đời Tựa Bóng Câu" }
  composer = "Tv. 143"
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
      (padding . 0.5)
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
  \partial 4 e8 c |
  f4. d16 g |
  g8 f f e |
  a4. g16 g |
  c8 c b c |
  d4. a16 a |
  b8 c a af |
  g2 ~ |
  g4 c,8 c |
  f4. d16
  <<
    { 
      \voiceOne
      d
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-2
      \tweak font-size #-2
      \parenthesize
      e
    }
  >>
  \oneVoice
  g8. f16 f8 e |
  a4. g16 g |
  c8 c b \slashedGrace { b16 ( } c8) |
  d4. a16 a |
  g8 e' d b |
  c2 ~ |
  c4 r8 \bar "||" \break
  
  g |
  e'4 d8 a ~ |
  a d b4 |
  c e,8 e ~ |
  e e a4 |
  a d,8 f ~ |
  f g c,4 |
  c c8 f ~ |
  f d g4 |
  g2 ~ |
  g8 [e'] d d |
  b c4 d8 |
  g,2 ~ |
  g8 g g af |
  g b4 d8 |
  c2 ~ |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r4 |
  R2*15
  r4.
  g8 |
  c4 g8 f ~ |
  f fs g4 |
  e c8 c ~ |
  c c e4 |
  f b,8 d ~ |
  d b a4 |
  a a8 d ~ |
  d c c4 |
  b2 ~ |
  b8 c g' fs |
  g a4 f8 |
  e2 ~ |
  e8 e e f |
  e d4 f8 |
  e2 ~ |
  e4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Ca mừng Chúa là núi đá cho tôi ẩn náu,
      Từng dạy tôi nên người thiện chiến,
      luyện thành tay võ nghệ cao cường,
      Là thành lũy, là đồn trú, khiên che, mộc đỡ.
      Nhờ Ngài nên tôi được giải thoát,
      Chư dân rầy đến quy phục tôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nghiêng trời xuống chạm tới núi cao cho tỏa khói,
	    Dùng loạt tên bay xẹt tia chớp,
	    diệt địch quân bấn loạn tan hàng,
	    Từ trời thẳm, nguyện Ngài hãy ra tay giải thoát,
	    Giựt mạng con lên khỏi vực thẳm
	    Xa tay quyền thế quân ngoại bang.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ôi lạy Chúa nhận lấy khúc tân ca mừng Chúa,
	    Huyền cầm con vang họa dâng tiến,
	    vì Ngài thương cứu mạng trung thần.
	    Ngài giải cứu khỏi quyền thế tay quân ngoại quốc,
	    Miệng toàn buông bao lời xảo trá,
	    Giơ tay thề, những luôn thề gian.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Mong được thấy, được thấy lũ con trai vừa lớn
	    Hùng mạnh như cây tràn nhựa sống,
	    đẹp tuối xuân thắm tươi muôn mầu,
	    Và được thấy bầy
	    \markup { \italic \underline "con" }
	    gái ta đầy khởi sắc,
	    Tuyệt vời như bao hình kiều nữ
	    In trên cột những cung điện kia.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Hoa mầu tốt được chất chứa trong kho đầy ứ
	    Bầy cừu chiên tăng dần lên mãi,
	    tràn ngập trên khắp nẻo nương đồng,
	    Bò mập béo chẳng gục chết hay tan đàn nữa,
	    Và cầu mong trên mọi nẻo phố
	    Không vang vọng tiếng ai sầu than.
    }
  >>
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Lạy Chúa, con người có là chi mà Ngài cần biết đến,
  phàm nhân đáng là gì mà Chúa phải quan tâm?
  Khác chi hơi thở, ôi kiếp người,
  Vùn vụt tuổi đời tựa bóng câu.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 10\mm
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
  ragged-bottom = ##t
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
