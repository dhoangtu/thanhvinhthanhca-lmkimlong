% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Lời Chúa Là Đèn Soi Con" }
  composer = \markup {
    \column {
      \line { "Tv. 118" }
      \line { "đoạn 14 (câu 105-112)"  }
    }
  }
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4. d8 b' g |
  g b16 b b8 c |
  c4 a8 d |
  e8. c16 a8 b |
  b2 ~ 
  b4 d8 d |
  g,8 a16 a a8 b |
  e,4 a8 a |
  d,8. a'16 a8 b |
  g2 ~ |
  g4 r8 \bar "||"
  
  g8 |
  g8 fs16 g e8 ef |
  d4. d16 b |
  d8 b' c b |
  a2 ~ |
  a4 r8 c |
  a a16 g fs8 d' |
  d4. b16 b |
  c8 d b16 (a) fs8 |
  g2 ~ |
  g8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  d8 b' g |
  g g16 g g8 a |
  a4 fs8 g |
  c8. a16 fs8 fs |
  g2 ~ |
  g4 fs8 fs |
  e e16 e d8 d |
  c4 c8 c |
  b8. c16 d8 d |
  b2 ~ |
  b4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Lời Chúa là đèn soi cho con tiến bước,
  là ánh sáng chỉ đường con đi.
  Đã ước nguyện nên nay con hết lòng
  giữ quyết định công minh của Ngài.
  <<
    {
      \set stanza = "1."
      Thân con bị muôn vàn khổ nhục,
      theo lời Ngài xin cứu sống con,
      Khứng nhận lời cảm tạ con dâng
      Và dạy con chứng tri của Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Kiếp sống vương mắc bao hiểm nghèo,
	    nhưng lệnh Ngài con vẫn không quên,
	    Ác nhân giăng bẫy dò quanh con,
	    Luật Ngài con quyết không lìa xa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ý Chúa là gia nghiệp trọn đời,
	    gieo vào lòng con những hân hoan,
	    Quyết tâm luôn thi hành thánh ước
	    Mà lòng con hướng theo chẳng ngơi.
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
  \key g \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
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
     (padding . 1)
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
                      (ly:pointer-group-interface::add-grob text
'side-support-elements syllable))
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
% kết thúc mã nguồn

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
