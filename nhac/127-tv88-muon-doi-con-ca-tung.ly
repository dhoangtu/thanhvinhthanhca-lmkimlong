% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Muôn Đời Con Ca Tụng" }
  composer = "Tv. 88"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 f8 |
  e8. f16 a8 f |
  d4. c8 |
  a'8 a4 g8 |
  bf4 r8 bf16 b! |
  c8 c d c |
  a4. g8 |
  bf a4 g8 |
  f4 \fermata \bar "||" \break
  
  e8. e16 |
  f8 d4 c8 |
  a' f bf a |
  g4 g8. g16 |
  c8 c4 a8 |
  g8. bf16 a8 g |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f8 |
  e8. f16 a8 f |
  d4. c8 |
  f8 f4 c8 |
  g'4 r8 g16 f |
  e8 f bf a |
  f4. e8 |
  g f4 e8 |
  a,4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Muôn đời con sẽ ca tụng Tình yêu thương của Chúa
  và ngàn năm con sẽ loan truyền lòng tín trung của Ngài.
  <<
    {
      \set stanza = "1."
      Vì tình yêu Ngài được thiết lập đến thiên thu,
      Lòng thành tín Chúa xây dựng mãi trên cung trời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Tầng trời chiếu dọi ngàn công trình Chúa nơi nơi,
	    Cộng đoàn các thánh ca tụng tín trung của Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Vì từ cõi trời nào ai người dám sánh vai,
	    Dù thần thánh đó, ai nào có thể so bì.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài thực lẫm liệt, ngự giữa thần thánh oai linh,
	    Quần thần bái kính, suy phục Chúa cả uy hùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Dẹp trận sóng cồn, đại dương Ngài trấn coi luôn,
	    Bầu trời trái đất, muôn loài Chúa đã tạo thành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Này bàn tay Ngài từng đã mạnh mẽ dương oai,
	    Bệ là chính nghĩa, cho thành tín đi dẫn đường.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Được tụng ca Ngài, này dân tộc phúc vinh thay,
	    Họ được tiến bước trông nhờ thánh nhan soi đường.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nguyện Ngài nhớ hoài: phù du phận chúng con đây,
	    Đời người dưới thế, ôi thực quá ư mỏng dòn.
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
  page-count = 1
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
}

TongNhip = {
  \key f \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
